c     ==================================================================
c     This program tests ARPACK (in shift-invert mode) on simple
c     diagonal matrices.
c     ==================================================================
      PROGRAM MAIN
      implicit none
      
      integer N
      parameter ( N=1024 )      !! matrix size
      
      integer i, count
      complex*16 sigma
      character*1 bmat
      character*2 which
      complex*16, dimension(:), allocatable :: resid, workd, workl, spec
      complex*16, dimension(:,:), allocatable :: V
      double precision tol
      double precision, dimension(:), allocatable :: rwork
      integer ido, info, NEV, NCV, lworkl, iparam(11), ipntr(14), ldv
      logical rvec
      logical, dimension(:), allocatable :: select
      complex*16, dimension(:), allocatable :: workev
      
      include 'debug.h'
      mcaupd = 1
      mcaup2 = 0
      mceupd = 0
      logfil = 6
      ndigit = -3
      
c     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c     %% Begin Computation

c     %% prepare ARPACK parameters
      ido=0                     !! first call to znaupd()
      info=0                    !! use random starting vector
      tol=0d0                   !! use machine precision
      bmat='I'                  !! standard eigenvalue problem
      which='LM'                !! largest part of spectrum
      NEV=min(7,N-2)
      NCV=min(NEV+2,N)
      lworkl=3*NCV**2 + 5*NCV
      ldv=N
      sigma=0d0
      
      print *,'N:',N
      print *,'NEV:',NEV
      print *,'NCV:',NCV
      print *,'lworkl:',lworkl
      print *,'sigma (shift):',sigma
      print *,'bmat:',bmat
      print *,'which:',which
      
c     %% allocate more storage
c     %% (don't bother checking status)
      allocate(resid(N))
      allocate(V(ldv,NCV))
      allocate(workd(3*N))
      allocate(workl(lworkl))
      allocate(rwork(N))
      
c     %% parameter vector
      iparam(1)=1               !! so we don't have to worry about shifts
      iparam(3)=10000           !! maximum number of iterations
      iparam(7)=3               !! shift-and-invert
      
      print *
      print *,'begin Arnoldi iterations'
      count=0
      
 10   continue                  !! bletch
      count=count+1
      call ZNAUPD(
     $     ido,                 !! reverse communication flag
     $     bmat,                !! standard eigenvalue problem
     $     N,                   !! dimension of matrix
     $     which,               !! which eigenvalues?
     $     NEV,                 !! desired number of eigenvalues
     $     tol,                 !! stopping criterion -- use default
     $     resid,               !! residual vector, irrelevant for first run
     $     NCV,                 !! number of columns in V
     $     V,                   !! Arnodi basis vectors
     $     ldv,                 !! number of rows in V
     $     iparam,              !! parameter vector (11 entries)
     $     ipntr,               !! pointers to work arrays (14 entries)
     $     workd,               !! work array
     $     workl,               !! work array
     $     lworkl,              !! >= 3*NCV**2 + 5*NCV
     $     rwork,               !! more workspace
     $     info                 !! 0 on start
     $     )
      
c     %% check status code
      if ( info .ne. 0 ) then
         print *,'znaupd(): nonzero status code:',info
         print *,'stop'
         stop
      endif
      
c     %% what to do now?
      if ( (ido .eq. -1) .or. (ido .eq. 1) ) then
         do i=0,N-1
            workd(ipntr(2)+i) = workd(ipntr(1)+i) / ( i+1 - sigma )
         enddo
         goto 10
      else if ( ido .ne. 99 ) then
         print *,'unknown opcode: stop'
         stop
      endif
      
c     %% post-processing for eigenvalues
      rvec=.false.
      allocate(select(NCV))
      allocate(spec(NEV+1))
      allocate(workev(2*NCV))
      print *,'now calling zneupd()'
      print *,'rvec:',rvec
      
      call ZNEUPD(
     $     rvec,                !! compute Ritz values only (in)
     $     'A',                 !! compute new Ritz vectors (in)
     $     select,              !! workspace (out)
     $     spec,                !! spectrum (out)
     $     V,                   !! ignored, actually (out)
     $     ldv,                 !! leading dimension of Z
     $     sigma,               !! complex eigenvalue shift
     $     workev,              !! more workspace
     $     bmat,                !! the rest of these are the same as
     $     N,                   !! earlier input to znaupd()
     $     which,
     $     NEV,
     $     tol,
     $     resid,
     $     NCV,
     $     V,
     $     ldv,
     $     iparam,
     $     ipntr,
     $     workd,
     $     workl,
     $     lworkl,
     $     rwork,
     $     info)
      
      if ( info .ne. 0 ) then
         print *,'zneupd(): nonzero status code:',info
         print *,'stop'
         stop
      else
         print *,'spectrum:'
         do i=1,NEV
            print *,i,spec(i)
         enddo
      endif
      
c     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c     %% Deallocate Storage (but why?)
      deallocate(resid)
      deallocate(V)
      deallocate(workd)
      deallocate(workl)
      deallocate(rwork)
      deallocate(select)
      deallocate(spec)
      deallocate(workev)
      end

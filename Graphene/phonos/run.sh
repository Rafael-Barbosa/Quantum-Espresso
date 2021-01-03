#! /bin/bash

# Remember to edit the pseudo potential path in graphene.scf.in

#SCF calculation
mpirun -np 8 pw.x < graphene.scf.in > graphene.scf.out

# Phonon calculation -  the most computational demanding part
mpirun -np 8 ph.x < graphene.ph.in > graphene.ph.out

# Interatomic Force Constants calculation
mpirun -np 8 q2r.x < graphene.q2r.in > graphene.q2r.out

# phonon frequencies along the BZ high symmetry lines
mpirun -np 8 matdyn.x < graphene.matdyn_disp.in > graphene.matdyn_disp.out

# plot phonon bands
mpirun -np 8 plotband.x < graphene.plotband

# calculates phonon density of states
mpirun -np 8 matdyn.x < graphene.matdyn_dos.in > graphene.matdyn_dos.out

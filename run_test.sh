#!/bin/bash -x
#$ -S /bin/bash
#$  -l v100=1
#$ -cwd
#$ -o ./logs
#$ -e ./logs
#$ -l s_vmem=10G
#$ -l mem_req=10G

# Junbi >>>
module use /opt/nvidia/hpc_sdk/modulefiles
module load nvcompilers/2020
#cd /home/saitohm/Documents/tokyo2020/naruse-code/run2
# <<<

# below ocasionarlly doesn't work
#BIN_TYPE=${1:-pgi}

# so enforced
BIN_TYPE=pgi

BIN=../ibm-saitohm-f90/jcl_sh1.$BIN_TYPE
MODEL=../make-city/scale1.0/model-with-outer.city # 50,000 visitors

MEETING=conference_games_hr#3_n#10000.csv
INTERV=inf200.csv
#INTERV=inf499.csv
#INTERV=inf500.csv
#CAFE=cafe.cfg
CAFE=extra.cfg

UPTODATE=48

for ((iseed = 0; iseed < 32; iseed++)); do
#for iseed in 99; do
  DATE=`date +%y%m%d-%H%M%S`
#  LOG=log.$BIN.$MODEL.$INTERV.$DATE
  LOG=log.$DATE
  TAG=${BIN_TYPE}_${DATE}_${iseed}
  echo seed $iseed:
#     0    1       2        3     4      5       6        7     8
  ./$BIN $MODEL $MEETING $INTERV $TAG $iseed $UPTODATE $CAFE -logTrip | tee $LOG
done


Rscript ../run2/plot-pop.r

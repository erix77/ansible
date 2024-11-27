#! /bin/bash

# Arret de toutes les VMs actives sur serveur ESXI :
#
# sshpass -p xxxxxxxxx ssh root@esxi ls
# ssh root@esxi esxcli vm process list
#
# La commande renvoie ci-dessous, le champ "World ID: 527611" est nécessaire pour demander l'arret d'une VM
#
#ubuntuc1
#   World ID: 527611
#   Process ID: 0
#   VMX Cartel ID: 527610
#   UUID: 56 4d 89 0e 68 65 d4 86-22 78 80 af 60 16 e0 e0
#   Display Name: ubuntuc1
#   Config File: /vmfs/volumes/661ab9c9-ea3e9a38-f0ba-d89ef3ff34e7/ubuntuc1/ubuntuX.vmx
#
#ubuntuc2
#   World ID: 527647
#   Process ID: 0
#   VMX Cartel ID: 527639
#   UUID: 56 4d ce 3a 6f a2 ca cd-59 aa de f6 7f f3 0c 8c
#   Display Name: ubuntuc2
#   Config File: /vmfs/volumes/661ab9c9-ea3e9a38-f0ba-d89ef3ff34e7/ubuntuc2/ubuntuX.vmx
#
# esxcli vm process kill --type <soft|hard|force> --world-id <vm_ID>
# ssh root@esxi esxcli vm process list | grep " World ID" | awk '{ print $3 }'
# 
# Mise en Maintenance de l'ESXi :
# ssh root@esxi esxcli system maintenanceMode set -e true
#
# Arret de l'ESXi :
# ssh root@esxi esxcli system shutdown poweroff --reason=Fin_de_la_Journée

Liste_VMs=$(ssh root@esxi esxcli vm process list | grep " World ID" | awk '{ print $3 }')

if [[ -n Liste_VMs ]]
then
  for id_vms in $(echo $Liste_VMs)
  do
    ssh root@esxi esxcli vm process kill --type soft --world-id $id_vms
    echo Arret de la vm $id_vms
    sleep 3
  done
else
  echo Toutes les VMs sont arretées
fi

#echo Mise en Maintenance de l\'ESXi
#ssh root@esxi esxcli system maintenanceMode set -e true

#echo Arrêt de l\'ESXi
#ssh root@esxi esxcli system shutdown poweroff --reason=Fin_de_la_Journée





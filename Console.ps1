function region1CLI { 
    $modèleserver = ""#Emplacement du disque parent serveur 
    $modèlecli = ""#Emplamcent du disque parent client
    [int]$iteration = 1
    [int]$iteration2 = 1
    [int]$iteration3 = 1
    [int]$compteur = 0
    [int]$compteur2 = 0
    [int]$compteur3 = 0
    while ($compteur,$compteur2,$compteur3  -lt 5){ #Tant que le compteur est inferieur à 5 la fonction continuera 
    $prefixe = "CLI" , "SRV" , "RTR" | Select-Object -First 1 #Le prefixe commencera par CLI
    $nomfinalevm = $prefixe+$iteration #Le nom finale de la vm sera CLI1 et fera une iteration de 1 pour creer CLI2,3,4 et 5.
    #Le chemin etant deja prefixer vers le lecteur D prendra comme chemibn CLI1,2 ou 3 et creera 2 dosseirs chacun (VM et VHD)
    New-Item -Path "D:\$nomfinalevm\VHD" , "D:\$nomfinalevm\VM" -ItemType Directory 
    #Le disque de differenciation se basera sur le modèle  $modèlecli = "D:\sources\Master_Win10_20h2_x86_G1.vhdx" 
    #et sera rediriger sue les dossiers que j'ai crée précèdemment
    New-VHD -ParentPath $modèlecli -Path "D:\$nomfinalevm\VHD\$nomfinalevm.vhdx" -Differencing
    #La machine sera stocker à cette endroit si c'est à dire D:\$nomfinalevm\VM accompagné du didsque de diff rée précèdemment  
    New-VM -Name $nomfinalevm -MemoryStartupBytes 1GB  -Path "D:\$nomfinalevm\VM"  -VHDPath "D:\$nomfinalevm\VHD\$nomfinalevm.vhdx" -Generation 1 
    #Pour finir , il yaura une iteration pour creer 4 autre machines avec mlememe principe .
    $iteration++
    $compteur++
     $prefixe2 = "CLI" , "SRV" , "RTR" | Select-Object -Last 1 #Le prefixe commencera par CLI
    $nomfinalevm2 = $prefixe2+$iteration2 #Le nom finale de la vm sera CLI1 et fera une iteration de 1 pour creer CLI2,3,4 et 5.
    #Le chemin etant deja prefixer vers le lecteur D prendra comme chemibn CLI1,2 ou 3 et creera 2 dosseirs chacun (VM et VHD)
    New-Item -Path "D:\$nomfinalevm2\VHD" , "D:\$nomfinalevm2\VM" -ItemType Directory 
    #Le disque de differenciation se basera sur le modèle  $modèlecli = "D:\sources\Master_Win10_20h2_x86_G1.vhdx" 
    #et sera rediriger sue les dossiers que j'ai crée précèdemment
    New-VHD -ParentPath $modèleserver -Path "D:\$nomfinalevm2\VHD\$nomfinalevm2.vhdx" -Differencing
    #La machine sera stocker à cette endroit si c'est à dire D:\$nomfinalevm\VM accompagné du didsque de diff rée précèdemment  
    New-VM -Name $nomfinalevm2 -MemoryStartupBytes 1GB  -Path "D:\$nomfinalevm2\VM"  -VHDPath "D:\$nomfinalevm2\VHD\$nomfinalevm2.vhdx" -Generation 2
    #Pour finir , il yaura une iteration pour creer 4 autre machines avec mlememe principe .
    $iteration2++
    $compteur2++
    $prefixe3 = "SRV"
    $nomfinalevm3 = $prefixe3+$iteration3 #Le nom finale de la vm sera CLI1 et fera une iteration de 1 pour creer CLI2,3,4 et 5.
    #Le chemin etant deja prefixer vers le lecteur D prendra comme chemibn CLI1,2 ou 3 et creera 2 dosseirs chacun (VM et VHD)
    New-Item -Path "D:\$nomfinalevm3\VHD" , "D:\$nomfinalevm3\VM" -ItemType Directory 
    #Le disque de differenciation se basera sur le modèle  $modèlecli = "D:\sources\Master_Win10_20h2_x86_G1.vhdx" 
    #et sera rediriger sue les dossiers que j'ai crée précèdemment
    New-VHD -ParentPath $modèleserver -Path "D:\$nomfinalevm3\VHD\$nomfinalevm3.vhdx" -Differencing
    #La machine sera stocker à cette endroit si c'est à dire D:\$nomfinalevm\VM accompagné du didsque de diff rée précèdemment  
    New-VM -Name $nomfinalevm3 -MemoryStartupBytes 1GB  -Path "D:\$nomfinalevm3\VM"  -VHDPath "D:\$nomfinalevm3\VHD\$nomfinalevm3.vhdx" -Generation 2
    #Pour finir , il yaura une iteration pour creer 4 autre machines avec mlememe principe .
    $iteration3++
    $compteur3++
    }
    Clear-Host
}

function region2SRV {
Remove-VM -Name *CLI* -Force 
Remove-Item -Path "D:\*CLI*" -Force -Recurse
Remove-VM -Name *RTR* -Force
Remove-Item -Path "D:\*RTR*" -Force -Recurse
Remove-VM -Name *SRV* -Force
Remove-Item -Path "D:\*SRV*" -Force -Recurse
Clear-RecycleBin -Force
Clear-Host
}


function sortie {


        Clear-Host
                Clear-Host
        Write-Host '  MerÃ§i davoir utilisÃ© notre Script '
            

Write-Host "   _____  ____   ____  _____    ______     ________ "
Write-Host  " / ____|/ __ \ / __ \|  __ \  |  _ \ \   / |  ____|"
Write-Host " | |  __| |  | | |  | | |  | | | |_) \ \_/ /| |__  " 
Write-Host " | | |_ | |  | | |  | | |  | | |  _ < \   / |  __|  "
Write-Host " | |__| | |__| | |__| | |__| | | |_) | | |  | |____ "
Write-Host "  \_____|\____/ \____/|_____/  |____/  |_|  |______|"                                                  
     Start-Sleep 6
        exit 
}


#CrÃ©ation d'une console pour demarrer des vm un peu plus rapidement . 
Clear-Host
$enterorexit =  Read-Host 'Souhaitez vous continuer'
while ($enterorexit -notmatch 'quitter')#Dans le cas d'une chaine de caractere
{   
    Write-Host "_____ _____ _____  _____ _   _ _____"  
    Write-Host "|_   _/  ___/  ___||  _  | | | /  ___|" 
    Write-Host "| | \ `--.\ `--. | | | | | | \ `--."  
    Write-Host "| |  `--. \`--. \| | | | | | |`--. \" 
    Write-Host '| |_/\__/ /\__/ /\ \_/ / |_| /\__/ /' 
    Write-Host '\___/\____/\____/  \___/ \___/\____/' 
    Write-Host '--------------------------------------' 
    Write-Host '***************SCRIPT JLORNEM**********' 
    Write-Host '--------------------------------------' 
    Write-Host 'Choix 1 :CONSTRUCTION DU LABORATOIRE VIRTUELLE' 
    Write-Host 'Choix 2 :SUPPRESSION DU LABORATOIRE VIRTUELLE' 
    Write-Host 'Choix 3 :QUITTER LE PROGRAMME ' 
    Write-Host '--------------------------------------' 
    $enterorexit =  Read-Host 'Menu du Script '
    switch ( $enterorexit )
    {
    
    1 { region1CLI }
    2 { region2SRV}
    3 { sortie

        }
    
    }

    }
  
  

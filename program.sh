echo $'Welcome!\nThis program is designed for doing multiple sequences alignment, finding conserved regions, and creating a phylogenitic tree for the alignments.'
echo $"Do you want to run in GUI or in command line?\nFor GUI, press (G)\nFor Command line, press (C)"
read GUI
if [ $GUI == 'G' ] || [ $GUI == 'g' ]
then
	echo $" "
	printf "Welcome\nThis program is designed for doing multiple sequences alignment, finding conserved regions, and creating a phylogenitic tree for the alignments.\n"
	printf 'Please choose the algorithm you want to use for alignment\n\nFor Clustal, press (w)\nFor Muscle, press (m)\nFor Mafft, press (mf)\n'
	read alg
	#echo 'Please enter the path of the multiple sequences fasta file'
	#input = $( zenity --file-seletion )
	#echo 'Please enter the output file name'
	#read output
	if [ $alg == 'W' ] || [ $alg == 'w' ]
	then
	  if zenity --question --text='Do you have clustal installed on your machine?'
	  then
	    zenity --info --text='Please select your fasta file.' --width=350 --height=200
	    #printf "Great!\nLet's start our program"
	    #printf '\nprogressing\n----------------------\n'
	    clustalo -i $( zenity --file-selection ) -o $( zenity --entry --text='Please enter the name of the results file' --width=350 --height=200) | zenity --progress --width=350 --height=200
	    zenity --info --text=$"Done!, your results file  is saved in the current working directory" --width=350 --height=200
	  else
	    if zenity --question --text='Do you want to install it?' --width=350 --height=200
	    then
	      sudo apt install -y clustalo | zenity --progress
	      zenity --info --text=$"Great!\nWe can start now" --width=350 --height=200
	      clustalo -i $( zenity --file-selection ) -o $( zenity --entry --text='Please enter the name of the results file' --width=350 --height=200) | zenity --progress --width=350 --height=200
	      zenity --info --text=$"Done!, your results file  is saved in the current working directory" --width=350 --height=200
	    else
	      zenity --info --text=$"Sorry, the tool should be installed" --width=350 --height=200
	    fi
	  fi

	elif [ $alg == 'm' ] || [ $alg == 'M' ]
	then
	  if zenity --question --text='Do you have Muscle installed on your machine?' --width=350 --height=200
	  then
	    zenity --info --text='Please select your fasta file.' --width=350 --height=200
	    muscle -in $( zenity --file-selection ) -out $( zenity --entry --text='Please enter the name of the results file' --width=350 --height=200) | zenity --progress --width=350 --height=200
	    zenity --info --text=$"Done!, your results file  is saved in the current working directory" --width=350 --height=200
	  else
	    if zenity --question --text='Do you want to install it?' --width=350 --height=200
	    then
	      sudo apt install -y muscle | zenity --progress --text=Installing...
	      zenity --info --text=$"Great!\nWe can start now" --width=350 --height=200
	      zenity --info --text='Please select the fasta file' --width=350 --height=200
	      muscle -in $( zenity --file-selection ) -out $( zenity --entry --text='Please enter the name of the results file' --width=350 --height=200) | zenity --progress --width=350 --height=200
	      zenity --info --text=$"Done!, your results file  is saved in the current working directory" --width=350 --height=200
	    else
	      zenity --info --text=$"Sorry, the tool should be installed" --width=350 --height=200
	    fi
	  fi
	elif [ $alg ==  'mf' ] || [ $alg == 'MF' ] || [ $alg == 'Mf' ]
	then
	  if zenity --question --text='Do you have Mafft installed on your machine?' --width=350 --height=200
	  then
	    if zenity --question --text='Do you want to run with default parameters?\nDefault are --auto --clustalout --treeout?' --width=350 --height=200
	    then
	      zenity --info --text='Please select your fasta file.' --width=350 --height=200
	      mafft --auto --clustalout --treeout  $( zenity --file-selection ) > $( zenity --entry --text='Please enter the name of the results file' ) | zenity --progress --width=350 --height=200
	      zenity --info --text=$"Done!, your results file  is saved in the current working directory" --width=350 --height=200
	    else
	      zenity --info --text='Please check terminal for manually adjusting parameters' --width=350 --height=200
	      mafft
	    fi
	  else
	    if zenity --question --text='Do you want to install it?' --width=350 --height=200
	    then
	      sudo apt install mafft | zenity --progress --text=Installing...
	      zenity --info --text=$"Great!\nWe can start now" --width=350 --height=200
	      if zenity --question --text='Do you want to run with default parameters?\nDefault are --auto --clustalout --treeout?' --width=350 --height=200
	      then
	        zenity --info --text='Please select your fasta file.' --width=350 --height=200
	        mafft --auto --clustalout --treeout  $( zenity --file-selection ) > $( zenity --entry --text='Please enter the name of the results file' --width=350 --height=200) | zenity --progress --width=350 --height=200
	        zenity --info --text=$"Done!, your results file  is saved in the current working directory"
	      else
	        zenity --info --text='Please check terminal for manually adjusting parameters'
	        mafft
	      fi
	    else
	      zenity --info --text=$"Sorry, the tool should be installed" --width=350 --height=200
	    fi
	  fi
	fi
	if zenity --question --text=$"Now, the MSA is done\nDo you want to visualize the phylogenitic tree?" --width=350 --height=200
	then
	  if zenity --question --text='Do you have figtree installed on your device?' --width=350 --height=200
	  then
			if zenity --question --text='Please select the tree file' --width=350 --height=200
			then
	  		figtree $( zenity --file-selection --text='Please select the tree file')
			fi
	  else
	    if zenity --question --text='Do you want to install it?' --width=350 --height=200
	    then
	      sudo apt install -y figtree | zenity --progress --text=Installing... | zenity --progress --width=350 --height=200
	      zenity --info --text=$"Great!\nWe can start now" --width=350 --height=200
	      figtree $( zenity --file-selection --text='Please select the tree file')
	    else
	      zenity --info --text=$"Sorry, the tool should be installed" --width=350 --height=200
	  fi
	fi
	fi
	#printf 'Now, the MSA is done\nDo you want to visualize the phylogenitic tree? (y/n)\n'
	#read tree
	if zenity --question --text=$"Do you want to check the conserved regions?\nN.B.This step requires Python 3." --width=350 --height=200
	then
		if zenity --question --text=$"Do you have python installed? " --width=350 --height=350
		then
			zenity --info --text=$"Please select the clustal alignment file" --width=350 --height=200
			cat $(zenity --file-selection) | python3 conreg.py > $(zenity --entry --text='What do you want to call the results file?' --width=350 --height=200)
		else
			if zenity --question --text=$"Do you want to install python? " --width=350 --height=350
			then
			  sudo apt install python3 | zenity --progress
			  zenity --info --text=$"Please select the clustal alignment file" --width=350 --height=200
			  cat $(zenity --file-selection) | python3 conreg.py > $(zenity --entry --text='What do you want to call the results file?' --width=350 --height=200)
			else
				zenity --info --text=$"Sorry, we can not proceed." --width=350 --height=200
			fi
		fi
	else
	  zenity --info --text=$"Ok\nConserved regions will not be shown" --width=350 --height=200
	fi
	if zenity --question --text=$"Do you want to design primers for these conserved regions?\nThis step requires\n1-primer3_core\n2-Python3\nDo you want to proceed?." --width=350 --height=350
	then
	  if zenity --question --text=$"Do you want to install primer3 and python? " --width=350 --height=350
	  then
	    sudo apt-get install -y build-essential g++ cmake git-all
	    git clone https://github.com/primer3-org/primer3.git primer3
	    cd primer3/src
	    make
	    make test
	  fi
	  zenity --info --text=$"Ok\nPlease return to the terminal to continue" --width=350 --height=200
	  echo 'Do you have the parameters file of the primers? (y) or want to create a new file with your parameters? (n) '
	  read parameters
	  if [ $parameters == 'y' ] || [ $parameters == 'Y' ]
	  then
	    echo 'Please enter the name/path of the parameters file'
	    primer3_core < zenity --file-selection
	  elif [ $parameters == 'n' ] || [ $parameters == 'N' ]
	  then
	    python3 parameters.py
	    echo 'Please select the parameters file you just created'
	    primer3_core < $(zenity --file-selection)
	    printf 'Please check the results file named as SEQID.for and SEQID.rev'
	    pwd
	  fi
	else
	  echo 'Ok'
	  echo 'Goodbye'
	fi
	printf '\nThis is all for this program\n'
	echo 'Thanks for using it'
	echo 'I hope you enjoyed it'
	printf '\nRegards,\nGroup3\n\n'
	echo 'Goodbye'
elif [ $GUI == 'c' ] || [ $GUI == 'C' ]
then
	echo $'Please choose the algorithm you want to use for alignment\nFor Clustal, press (w)\nFor Muscle, press (m)\nFor Mafft, press (mf)'
	read alg
	echo 'Please enter the path of the multiple sequences fasta file'
	read input
	echo 'Please enter the output file name'
	read output
	if [ $alg == 'W' ] || [ $alg == 'w' ]
	then
	echo 'Do you have clustal on your machine?? (y/n)'
		read ans1
		if [ $ans1 == 'n' ] || [ $ans1 == 'N' ]
		then
			echo 'Do you want to install it? (y/n)'
			read aaa
			if [ $aaa = 'Y' ] || [ $aaa = 'y' ]
			then
				sudo apt install -y clustalo
				printf "Great!\nWe can start now"
				printf '\nProcessing\n----------------------\n'

				clustalo -i $input -o $output
				printf 'Done!, check the results file in'
				pwd
			else
				echo 'Sorry, the tool should be installed'
				echo 'Goodbye'
			fi
		elif [ $ans1 == 'Y' ] || [ $ans1 == 'y' ]
		then
			printf "Great!\nLet's start our program"
			printf '\nProcessing\n----------------------\n'
			clustalo -i $input -o $output
			printf 'Done!, your results file  is saved in'
			pwd
		fi
	elif [ $alg == 'm' ] || [ $alg == 'M' ]
	then
	printf 'You have choosen Muscle\nDo you have Muscle installed on your device?'
		read ans2
		if [ $ans2 == 'y' ] || [ $ans2 == 'Y' ]
		then
			echo $"Great, let's start our program"
			printf '\nProcessing\n----------------------\n'
			muscle -in $input -out $output
			printf 'Done!, your results file is saved in'
			pwd
		elif [ $ans2 == 'n' ] || [ $ans2 == 'N' ]
		then
			echo 'Do you want to install it? (y/n)'
			read aaa
			if [ $aaa = 'Y' ] || [ $aaa = 'y' ]
			then
				sudo apt install -y muscle
				printf "Great!\nWe can start now\n"
				printf '\nProcessing\n----------------------\n'
				muscle -in $input -out $output
				printf 'Done!, your results file is saved in'
				pwd
			else
				echo 'Sorry, the tool should be installed'
				echo 'Goodbye'
			fi
		fi
	elif [ $alg ==  'mf' ] || [ $alg == 'MF' ] || [ $alg == 'Mf' ]
	then
	echo 'Do you have Mafft installed? (y/n)'
		read ans3
		if [ $ans3 == 'n' ] || [ $ans3 == 'N' ]
		then
			echo 'Do you want to install it? (y/n)'
			read aaa
			if [ $aaa = 'Y' ] || [ $aaa = 'y' ]
			then
				sudo apt install -y mafft
				printf "Great!\nWe can start now"
				echo 'Do you want to run with the default parameters set by the program? (y/n)'
				echo 'Defaults are: mafft --auto --clustalout --treeout input > output'
				read ans1
				if [ $ans1 == 'Y' ] || [ $ans1 == 'y' ]
				then
					printf '\nProcessing\n----------------------\n'
					mafft --auto --clustalout --treeout $input > $output
					printf 'Done!, your results file is called '$output' and it is saved in'
					pwd
				elif [ $ans1 == 'N' ] || [ $ans1 == 'n' ]
				then
					printf 'Please enter your own parameter s specifying the input and output files\n'
					mafft
				fi
			elif [ $aaa == 'n' ] || [ $aaa == 'N' ]
			then
				echo 'Sorry, the tool should be installed'
				echo 'Goodbye'
			fi
		elif [ $ans3 == 'Y' ] || [ $ans3 == 'y' ]
		then
			printf "This is Nice!\nLet's start"
			echo 'Do you want to run with the default parameters set by the program? (y/n)'
			echo 'Defaults are: mafft --auto --clustalout --treeout input > output'
			read ans1
			if [ $ans1 == 'Y' ] || [ $ans1 == 'y' ]
			then
				printf '\nProcessing\n----------------------\n'
				mafft --auto --clustalout --treeout $input > $output
				printf 'Done!, your results file is saved in '
				pwd
			elif [ $ans1 == 'N' ] || [ $ans1 == 'n' ]
			then
				printf 'Please enter your own parameters specifying the input and output files\nmafft'
				mafft
				printf 'Done!, your results file is saved in'
				pwd
			fi
		fi
	fi
	printf 'Now, the MSA is done\nDo you want to visualize the phylogenitic tree? (y/n)\n'
	read tree
	if [ $tree == 'y' ] || [ $tree == 'Y' ]
	then
		echo 'Do you have figtree installed on your device?'
		read fig
		if [ $fig == 'y' ] || [ $fig == 'Y' ]
		then
			echo 'Pleae enter name of the tree file'
			read tr
			echo 'Please close the figtree window once you have finished to complete program'
			figtree $tr
		elif [ $fig == 'n' ] || [ $fig == 'N' ]
		then
			echo 'You have to install figtree. Do you want to proceed? (y/n)'
			read ans4
			if [ $ans4 == 'y' ] || [ $ans4 == 'Y' ]
			then
				sudo apt install -y figtree
				echo 'Pleae enter name of the tree file'
				read tr
				echo 'Please close the figtree window once you have finished to complete program'
				figtree $tr
			elif [ $ans4 == 'n' ] || [ $ans4 == 'N' ]
			then
				echo 'Sorry,  we can not proceed'
			fi
	elif [ $tree == 'n' ] || [ $tree == 'N' ]
	then
		echo 'You have selected not to show the phylogenetic tree'
	fi
	fi
	echo 'Do you want to check the conserved regions? (y/n)'
	read con
	if [ $con == 'n' ] || [ $con == 'n' ]
	then
		echo 'Thank you for using this program.'
		echo 'Goodbye'
	elif [ $con == 'y' ] || [ $con == 'Y' ]
	then
		echo 'Do you have python 3 installed on your machine? (y/n)'
		read py
		if [ $py == 'y' ] || [ $py == 'Y' ]
		then
			echo 'What do you want to call the results file?'
			read results
			echo $"Please select the clustal alignment file"
			cat $(zenity --file-selection) | python3 conreg.py > $results
		elif [ $py == 'n' ] || [ $py == 'N' ]
		then
			echo 'Do you want to install python? '
			read apy
			if [ $apy == 'y' ] || [ $apy == 'Y' ]
			then
				sudo apt install -y python3
				echo 'What do you want to call the results file?'
				read results
				echo $"Please select the clustal alignment file"
				cat $(zenity --file-selection) | python3 conreg.py > $results
			else
				echo 'Sorry, python should be installed in order to find conserved regions.'
			fi
		fi
	fi
	echo 'Do you want to design primers for these conserved regions? (y/n)'
	read pd
	if [ $pd == 'y' ] || [ $pd == 'Y' ]
	then
		echo 'Do you have primer3 installed on your machine? (y/n)'
		read p3
		if [ $p3 == 'y' ] || [ $p3 == 'Y' ]
		then
			printf "Great!\nLet's start working! "
			echo 'Do you have the parameters file of the primers? (y) or want to create a new file with your parameters? (n) '
			read parameters
			if [ $parameters == 'y' ] || [ $parameters == 'Y' ]
			then
				echo 'Please enter the name/path of the parameters file'
				primer3_core < $(zenity --file-selection)
				echo 'Please check the forward and reverse primers file in your current working directory'
			elif [ $parameters == 'n' ] || [ $parameters == 'N' ]
			then
				python3 parameters.py
				echo 'Please select the parameters file you just created'
				primer3_core < $(zenity --file-selection)
				printf 'Please check the results file named as SEQID.for and SEQID.rev'
				pwd
			fi
		elif [ $p3 == 'n' ] || [ $p3 == 'N' ]
		then
			echo 'Do you want to install it? (y/n)'
			read ip
			if [ $ip == 'n' ] ||  [ $ip == 'N' ]
			then
				echo 'Sorry, the program cannot complete the task'
				echo 'Goodbye'
			elif [ $ip == 'Y' ] ||  [ $ip == 'y' ]
			then
				echo 'Instlling primer3, this may take sometime'
				echo 'Please be patient..........'
				sudo apt-get install -y build-essential g++ cmake git-all
				git clone https://github.com/primer3-org/primer3.git primer3
				cd primer3/src
				make
				make test
				echo 'Installation is done'
				echo 'Do you have the parameters file of the primers? (y) or want to create a new file with your parameters? (n) '
			  read parameters
			  if [ $parameters == 'y' ] || [ $parameters == 'Y' ]
			  then
			    echo 'Please enter the name/path of the parameters file'
			    primer3_core < $(zenity --file-selection)
			  elif [ $parameters == 'n' ] || [ $parameters == 'N' ]
			  then
			    python3 parameters.py
			    echo 'Please select the parameters file you just created'
			    primer3_core < $(zenity --file-selection)
			    printf 'Please check the results file named as SEQID.for and SEQID.rev'
			    pwd
			  fi
			else
			  echo 'Ok'
			fi
		fi
	elif [ $pd == 'n' ] || [ $pd == 'N' ]
	then
		echo 'Ok'
	fi
fi
printf '\nThis is all for this program\n'
echo 'Thanks for using it'
echo 'I hope you enjoyed it'
printf '\nRegards,\nMohamed Ali 3\n'
echo 'Goodbye'

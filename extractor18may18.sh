#!/bin/bash
read fname 
#reading url path from user
echo "Process started."
#script started
mkdir process
cd process
###########################################################################################
#Debugging function ignore

###########################################################################################

#working just for debugging
get_domain()
{
	#getting domain name so that we may prevent files outside parent
	echo $fname | cut -d'/' -f3 >domain
	echo $n_domain | cut -d'/' -f3 >newdomain
	domain=$(cat domain)
	new_domain=$(cat newdomain)
	touch list.log
}


#working
get_css()
{
	#getting links which redired to css file
	grep css list.log >>cssf.log
}


#working
get_linecount()
{
	temp_lines=$( cat output_temp.log | wc -l )
	lines=$( cat list.log | wc -l )
	lines_css=$( cat link_css.log | wc -l )
}


#fname is url entered
#n_domain is permanently changed domain name if domian is changed fname=n_domain
#moved.txt holds the name of new domain
#cssf.log holds the links to css files
#file holds the contents curled from a web page to extract all the links from it
#$domain and $new_domain stores the domains name
#output_temp.log holds the [all] links grabbed from web page
#link_css.log holds the [all] links grabbed from <style> script in a web page
#temp_lines holds the value of number of line in output_temp.log
#list.log is expected to containg all the different links with nonrepetetions
#lines holds the value of number of line in list.log
#lines_css holds the value of number of line in link_css.log
###########################################################################################
#Debugging function ignore

###########################################################################################







#working
moved_domain()
{
	#void output if no redirection,checking link redirection
	curl -i "$fname" -L | egrep -A 10 '301 Moved Permanently|302 Found' | grep 'Location' | awk -F': ' '{print $2}' | tail -1 >moved.txt
	n_domain=$(cat moved.txt)
}



#working
get_file_for_link()
{
	#if new domain name is void means domain hhas not changed
	if [ "$n_domain" == "" ]
		then
   			echo "Domain has not changed"
   			curl $fname >file
		else
			#so new url i.e. fname will be n_domain
   			echo "Domain has changed"
   			#downloading new url's content in file
   			curl $n_domain >file
   			fname=n_domain
   		fi
	
	#wget $fname -O file	
}

#working
get_links_from_files()
{	
	#storing each links in file output_temp
	grep -Po "(?<=href=')[^']*" file > output_temp.log
	grep -Po '(?<=href=")[^"]*' file > output_temp.log
	grep -Po '(?<=:url)[^)]*' file >link_css.log
	#:url(/images/nav_logo242.png)
	#output is (/images/nav_logo229.png	
}




#Check
correcting_css()
{
	((p_lines++))
	a=0
	while [ "$a" -lt "$p_lines" ]    # run loop till no of lines in temp
	do
		#read line and store them in variable line
   		css_line=$(head -"$a" $1 | tail -1)
   		((a++))
		#echo $css_line
		echo $css_line>temp_css_line
		#echo $css_line
		#output is (/images/nav_logo229.png
		value=$(cat temp_css_line | cut -c 2-)
		echo $value>>corrected_css_links 
		css_line=$value
		#corrected output is /images/nav_logo229.png
		##########################################################################
		#following lines are to be checked
		if [[ ($css_line == "'"*)||($css_line == '"'*) ]]; 
		then 
			#if link is of type :url('/images/nav_logo242.png') 
			#strong in file tempv
			echo $css_line>tempv
			#reading from file tempv without "*" or '*' and storing them in css_temp
			grep -Po "(?<=')[^']*" tempv >> corrected_css_links
			grep -Po '(?<=")[^"]*' tempv >> corrected_css_links
		else
			#echo "ok $css_line"
			echo
		fi
		##########################################################################
   		
	done
	#if link is of type :url('/images/nav_logo242.png')
}

#working
get_linecount_arguments()
{
	# $1 is aruments (file name) whose line is to be counted
	p_lines=$( cat $1 | wc -l )
}
#working
correcting_links_parameters()
{
	current=fname
	#required
	((p_lines++))
	#initialisation
	a=1
	while [ "$a" -lt "$p_lines" ]    # run loop till no of lines in temp
	do
		#read line and store them in variable line
		# $1 is aruments (file name) whose line is to be counted
   		line=$(head -"$a" $1 | tail -1)
   		((a++))
		#echo $line
		#check wheter the url already contains the full path
		echo $line>check
		#echo $line
		echo $line | cut -d'/' -f3 >check
		temp_domain=$(cat check )
		if [ "$domain" == "$temp_domain" ]
		then
   			#echo "Link is acessible"
   			echo $line >>final_list
   			#echo $line>>replace_links
			#echo $line
			#printf '%s\n' "${line//$domain/}"
			#echo $line>>replace_links
			#echo $line
   			#echo $line
		else
	
			if [[ $line == /* ]]; 
			then 
				#links starting with / are now corrected to redirect to site
				foo=$fname$line
				#echo $foo
				echo $foo >>final_list_temp
				echo $foo
				#while correcting link search from downloaded link and replace with next link from document replace_links
				###############################################
				#echo $line>>replace_links
				#echo $line
				#printf '%s\n' "${line//$domain/}"
				#echo $line>>replace_links
				#echo $line
				###############################################
			else 
   				echo $line>>rejected.list
   				#echo "$line :_with domain_: $temp_domain "

			fi
   			
   		fi
   		
	done

}


#not completed
storing_to_list()
{
	#required
	((temp_lines++))
	#initialisation
	a=1
	while [ "$a" -lt "$temp_lines" ]    # run loop till no of lines in temp
	do
		#read line and store them in variable line
   		line=$(head -"$a" output_temp.log | tail -1)
   		((a++))
		#echo $line
		#linear search second loop
		b=1
		found=0
		#while [[ ]]; do
			#statements
		#done
   		
	done
}

##main program starts here
#########################################################################
#########################################################################
#checking permanently moved domain
moved_domain
#get the file for all the links from url entered
get_file_for_link
#Funtion to store domain name into varible $domain and $new_domain
get_domain
#grab all the links from the file previously downloaded
get_links_from_files
#to get all the line counts in file outupt_temp.log list.log link_css.log
get_linecount

echo $temp_lines
echo $lines
echo $domain
echo $new_domain

###########################################################
#must be called togeter
#correcting_links
get_linecount_arguments output_temp.log
correcting_links_parameters output_temp.log
###########################################################

###########################################################
#must be called togeter
get_linecount_arguments link_css.log
correcting_css link_css.log
###########################################################
get_linecount_arguments corrected_css_links
correcting_links_parameters corrected_css_links

##main program ends here
#########################################################################
#########################################################################

regionsToIgnore=("eu-central-1" "eu-west-1")
for region in `aws ec2 describe-regions --output text | cut -f3`
do
     if [[ ! " ${regionsToIgnore[@]} " =~ " ${region} " ]]; then
     	echo -e "\nListing Instances in region:'${region}'..."
     	#aws ec2 describe-instances --region $region
     fi
done

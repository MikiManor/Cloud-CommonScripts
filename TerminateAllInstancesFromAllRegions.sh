regionsToIgnore=("eu-central-1" "eu-west-1")
for region in `aws ec2 describe-regions --output text | cut -f3`
do
     if [[ ! " ${regionsToIgnore[@]} " =~ " ${region} " ]]; then
     	echo -e "\nListing Instances in region:'${region}'..."
     	instances=`aws ec2 describe-instances --region ${region}  | grep InstanceId | awk '{print $2}' | cut -d \" -f2` 
        for instance in ${instances}; do
		aws ec2 modify-instance-attribute --region ${region} --instance-id ${instance} --no-disable-api-termination
		aws ec2 terminate-instances --region ${region} --instance-ids ${instance}
	done
     fi
done

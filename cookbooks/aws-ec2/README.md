# sample

TODO : sample/recipe/ec2-fetch.rb

Two Ruby Blocks

1) Fetch Instance Id using AWS CLI (aws ec2 describe-instances) and store the value in an attribute node.default[:sample][:instanceid] and pass it 2nd Ruby block to create AMI 

2) Create AMI using AWS CLI (aws ec2 create-image) with values fetched from 1st Ruby block and give a name to AMI created using Data bag Item sample in Data bag Attributes and version passed as parameter with the chef-client -j (option)


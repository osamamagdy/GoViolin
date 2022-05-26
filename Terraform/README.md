
# File Structure

### Terraform
The folder contains scripts used for provisioning one instances that runs the application docker image, and handle requests.
### How to use 
1 - Create a .env inside the terraform/slave directory file to store the needed credentials </br>
2 - Go to your aws account and create an IAM user with root priviliges (maybe all these priviliges are not really needed but for future development) </br>
3 - Store them in the following names in the .env file </br>
'''
AWS_ACCESS_KEY_ID="anaccesskey"
AWS_SECRET_ACCESS_KEY="asecretkey"
'''
</br>
4 - Create an EC2 key-value pair named "slave" on aws and download it inside the terraform directory under the name `slave.pem` (note that pem is required as we work with openssh) </br> 
5 - The downloaded file is required when you want to ssh into your server by running </br>
'''
chmod 400 slave.pem
ssh -i "slave.pem" ubuntu@{YOUR_Public_IPv4_DNS}
'''
</br>
6 - Run the host.sh script to do all the required steps for you to provision all resources </br>
'''
chmod u+x host.sh
./host.sh   (may ask you for sudo password so, run it as a sudo user)
'''
</br>

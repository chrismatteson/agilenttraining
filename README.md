This module stands up a windows training classroom environment.
In order to use this module, do the following steps:

1) Create an IAM role in AWS with the ability to provision nodes
2) Create a VPC in AWS for this to live inside
3) Create a security group in AWS to allow internode communication
4) Create a m3.xlarge redhat 7 VM with sufficent disk space and
install Puppet Enterprise
5) Git clone this project to the modules directory
 - https://github.com/chrismatteson/windowstraininglab
6) Run the script at windowstrainingla/scripts/deploy.sh
7) Add students to the common.yaml of hiera in this format:

windowstrainingla::students_hash:
 testing:
 - accountname: testing
 - fullname: testing lastname
 - password: P@ssw0rd!
 moretest:
 - accountname: moretest
 - fullname: moretest lastname
 - password: P@ssw0rd!

8) Logon to training-rd-01. Open Remote Desktop Gateway Manager (tsgateway.msc).
Import the policy settings file located at c:\tsgateway.xml.  Create and 
import a self signed cert by right clicking on the server, choosing properties
and navigating to the ssl tab.

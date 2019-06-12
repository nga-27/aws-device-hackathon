# stop script on error
set -e

# Check to see if root CA file exists, download if not
if [ ! -f ~/Desktop/root-CA.crt ]; then
  printf "\nDownloading AWS IoT Root CA certificate from AWS...\n"
  curl https://www.amazontrust.com/repository/AmazonRootCA1.pem > ~/Desktop/root-CA.crt
fi

# install AWS Device SDK for Python if not already installed
if [ ! -d ./aws-device-hackathon ]; then
  printf "\nInstalling AWS SDK...\n"
  git clone https://github.com/nga-27/aws-device-hackathon.git
  pushd aws-device-hackathon
  python setup.py install
  popd
fi

# run pub/sub sample app using certificates downloaded in package
printf "\nRunning pub/sub sample application...\n"
python ~/Desktop/aws-device-hackathon/samples/basicPubSub/basic_hackathon_1.py -e a26y2sst8zk5bt-ats.iot.us-east-1.amazonaws.com -r ~/Desktop/root-CA.crt -c ~/Desktop/e11f9f12f1.cert.pem -k ~/Desktop/e11f9f12f1.private.key

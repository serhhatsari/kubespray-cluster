# !/bin/bash

# Create nodes with vagrant
vagrant up

# Clone Kubespray
git clone https://github.com/kubernetes-sigs/kubespray

# Change directory
cd kubespray

cp -rfp inventory/sample inventory/mycluster

declare -a IPS=(192.168.56.10 192.168.56.11)

CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml -u vagrant

cd ..

ansible-playbook -i inventory/hosts setup-kubeconfig.yaml -u vagrant
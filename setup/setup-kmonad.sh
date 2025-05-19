sudo groupadd uinput
sudo usermod -aG input,uinput jonas
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee -a /etc/udev/rules.d/40-uinput.rules

tmux kill-session -t tf_sdk
tmux kill-session -t tf_info
sudo sed -i .back "/threefold/d" /private/etc/hosts

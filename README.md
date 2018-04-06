#### config vim
* cd ~/.vim/bundle/
* git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
* vim ~/.vimrc
* :BundleInstall
#### config tmux
* yum isntall tmux
* cp .tmux.conf ~/
#### install from dockerFile

1. Download ubuntu/centos all versions dockerfile from nvidia
	* git clone https://gitlab.com/nvidia/cuda.git
	* cd cuda
	* git branch -a
	* git checkout <branch>
2. Build target-docker image
	* modify Dockerfile repository="nvidia/cuda"
	* Modify/add personal_config into Dockerfile
	* remember to make cuda version with image cuda version same
	* docker build -t <repo_name>/<tag_name:version>  <target_folder_path>
3. Make container from image
	* sudo nvidia-docker run --name="name" --hostname="name" -v /home/wchen:/home/wchen -p 8080:8080 -p 6060:6060 -td <image_name>
4. Enter container
	* docker exec -it <container_name> bash
	* source ~/.bash_profile_gpu
5. check cuda install
	* nvidia-smi

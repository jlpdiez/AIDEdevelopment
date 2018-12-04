from pathlib import Path
import subprocess

rootdir = Path('../')
#Return a list of directories "*interview"
dir_list = [f for f in rootdir.glob('**/*interview') if f.is_dir()]
print(dir_list)
#Execute "mvn site" command in each of the folders
for d in dir_list:
	subprocess.Popen("mvn site", cwd=str(d), shell=True)
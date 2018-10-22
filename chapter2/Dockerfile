FROM python:3.7

RUN apt-get update

# Copy file of required Python packages
COPY requirements.txt .

# Switch to directory of jupyter notebooks
WORKDIR /jupyter_notebooks

# Install Python packages
RUN pip install -r ../requirements.txt

# Start jupyter-notebook server
CMD jupyter-notebook --no-browser --ip="*" --allow-root --NotebookApp.allow_remote_access=True 

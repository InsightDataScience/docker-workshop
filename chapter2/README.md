# Chapter 2: A Jupyter-Notebook Server!

Let us again check out the Dockerfile. Note that we are pip installing the content of requirements.txt. Jumping into this, we notice that we are installing everything we need for Jupyter Notebooks!

Explain the whole run command and the mounting thing.
Explain the copy thing for requirements

Let us run it!

docker build -t jupyter .
docker run -p 8888:8888 -v notebooks:/jupyter_notebooks --name jupyter jupyter

Now make the notebook

docker stop jupyter
docker rm jupyter



Add Screenshot of website.

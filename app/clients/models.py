from django.db import models
from viewflow.models import Process


class NewClientProcess(Process):
    name = models.CharField(max_length=150)
    email = models.CharField(max_length=150)
    phone = models.CharField(max_length=150) 
    approved = models.BooleanField(default=False)
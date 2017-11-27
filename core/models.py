from django.db import models

class Curso(models.Model):
    nome_curso = models.CharField("Nome do Curso",max_length =30)
    sigla_curso = models.CharField("Sigla do Curso",max_length =50)
    coordenador = models.CharField("Coordenador", max_length =50)
    
    def __str__(self):
        return self.nome_curso

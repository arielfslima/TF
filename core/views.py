from django.shortcuts import render
from django.views.decorators.csrf import ensure_csrf_cookie
from django.http import HttpResponseRedirect
from django.core.urlresolvers import reverse
from core.forms import Curso

def index (requisito):
    return render(requisito,'index.html')
def contato(requisito):
    if requisito.POST:   
        form = ContatoForm(requisito.POST)
        if form.is_valid():
            form.envia_email()
    else:
        form = ContatoForm()
    texto ={
        "form":form
    }
    return render(requisito,'contato.html',texto)   
def cursos (requisito):
    return render(requisito,'cursos.html')
def contato(requisito):
    return render(requisito,'contato.html')
def contatos_profs (requisito):
    return render(requisito,'contatos_profs.html')
def adm (requisito):
    return render(requisito,'adm.html')
def bancodedados (requisito):
    return render(requisito,'bancodedados.html')
def jogosdigitais (requisito):
    return render (requisito,'jogosdigitais.html')
def si (requisito):
    return render(requisito,'si.html')
def ti (requisito):
    return render(requisito,'ti.html')
def noticias (requisito):
    return render(requisito,'noticias.html')
def formulario_matricula (requisito):
    return render(requisito,'formulario_matricula.html')
def aluno (requisito):
    return render(requisito,'aluno.html')
def professor (requisito):
    return render(requisito,'Professor.html')
def meusdadosaluno (requisito):
    return render (requisito,'meus_dados_aluno.html')
def notas (requisito):
    return render (requisito,'notas.html')
def notasprof (requisito):
    return render (requisito,'notas_prof.html')
def meusdadosprof (requisito):
    return render (requisito,'meus_dados_professor.html')

from aluno import Aluno
class Arquivos_Resposta(Aluno):

    def _init_(self):
        self.nome_disciplina = None
        self.ano_ofertado = None
        self.semestre_ofertado = None
        self.id_turma = None
        self.numero_questao = None
        self.ra_aluno = self.ra
        self.arquivo = None

    '''Característica 38 - Resumo das entregas pendentes (professor).'''

    def entregas_pendentes(self):
        lista_concluido = []
        lista_pendente = []
        for i in lista_pendente:
            lista_pendente.append(self.ra_aluno)
            if self.arquivo == True:
                lista_pendente.remove(self.ra_aluno)
                lista_concluido.append(self.ra_aluno)

        return (lista_pendente)

    '''Característica 37 - Resumo das entregas ecebidas (professor)'''

    def entregas_concluidas(self):
        lista_concluido = []
        lista_pendente = []
        for i in lista_pendente:
            lista_pendente.append(self.ra_aluno)
            if self.arquivo == True:
                lista_pendente.remove(self.ra_aluno)
                lista_concluido.append(self.ra_aluno)

        return (lista_concluido)
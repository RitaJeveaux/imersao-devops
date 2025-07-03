
# Etapa 1: Imagem Base
# Usamos uma imagem oficial do Python. A versão 'slim' é menor e ideal para produção.
# O README especifica Python 3.10 ou superior.
FROM python:3.10-slim

# Etapa 2: Variáveis de Ambiente
# Impede o Python de gerar arquivos .pyc, economizando espaço.
ENV PYTHONDONTWRITEBYTECODE 1
# Garante que a saída do Python seja enviada diretamente para o terminal sem buffer.
ENV PYTHONUNBUFFERED 1

# Etapa 3: Diretório de Trabalho
# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Etapa 4: Instalação de Dependências
# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar Código da Aplicação
# Copia todos os arquivos do projeto para o diretório de trabalho no contêiner.
COPY . .

# Etapa 6: Comando de Execução
# Comando para iniciar a aplicação com Uvicorn.
# O host '0.0.0.0' torna a aplicação acessível de fora do contêiner.
# A flag --reload foi removida, pois é para desenvolvimento, não para produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]


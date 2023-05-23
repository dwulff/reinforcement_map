import openai
import os
import math
import pandas as pd

openai.api_key = "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"

def get_embedding(texts):
  n = math.ceil(len(texts) / 100)
  embedding = []  
  for i in range(n):
    fr = 0 + 100 * i
    to = min(fr + 100, len(texts)) 
    print(to)
    texts_i = texts[fr:to]
    response = openai.Embedding.create(
      input=texts_i,
      model="text-embedding-ada-002")
    emb = [response["data"][j]["embedding"] for j in range(len(texts_i))]
    embedding += emb
  return embedding

abstracts = pd.read_csv("1_data/data.csv").loc[:,"Abstract"].values.tolist()

embedding = get_embedding(abstracts)
with open('1_data/embedding/gptada_title_abstracts.txt','w') as f:
    for i in range(len(embedding)):
        f.write(to_string(embedding[i]) + "\n")

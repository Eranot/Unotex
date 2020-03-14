def get_written_path(path, last_vertex):
    written_path = []

    for i in range(len(path)-1):
        if last_vertex == None: #Se nao houver um ultimo vertice, deduz-se que o caminho sera frente
            written_path.append("frente")
        else:
            written_path.append(map[path[i]][last_vertex][path[i+1]]) #Adiciona a direcao contida no array map
        last_vertex = path[i]

    return written_path
def add_neighbours_to_queue(index, history): #Adiciona os vizinhos de um vertice na fila
    global queue

    h = history.copy()
    h.append(index)

    for i in map[index]:
        if(i != 0):
            queue.put({
                'index': i,
                'history': h
            })

def visit_node(end_vertex):
    if queue.empty():
        return -1

    node = queue.get() #Retira um vertice da fila

    if node['index'] == end_vertex: #Se chegou no vertice final
        return node

    if node['index'] in visited: #Se o vertice ja foi visitado
        return None

    visited[node['index']] = True #Define o vertice atual como visitado
    add_neighbours_to_queue(node['index'], node['history'])

    while True:
        ret = visit_node(end_vertex) #Chama a funcao recursivamente ate achar o end_vertex
        if ret != None:
            return ret
        elif ret == -1:
            return None
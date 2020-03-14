visited = {}
queue = Queue() #Fila em que os vertices sao adicionados

def get_path(start_vertex, end_vertex):
    global visited
    global queue

    visited = {}
    queue = Queue()

    queue.put_nowait({
        'index': start_vertex,
        'history': []
    })

    result = visit_node(end_vertex) #Visita um vertice buscando o end_vertex
    path = result['history']
    path.append(end_vertex)
    return path #Retorna o array de vertices
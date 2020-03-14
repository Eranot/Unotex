import mapa_uno as mapa

current_vertex = int(input('Vertice de inicio: ')) #Lendo vertice inicial
final_vertex = int(input('Vertice final: ')) #Lendo vertice final
path = mapa.get_path(current_vertex, final_vertex) #Obtendo o caminho entre os dois vertices
directions = mapa.get_written_path(path, mapa.last_vertex) #Obtendo as direcoes do caminho
video_capture = VideoCaptureAsync()
video_capture.start()
intersection_count = 0
directions_count = 0

while (True):
    ret, frame = video_capture.read() #Captura uma imagem da camera
    if ret:
        final_frame = pipeline(frame) #Passa a imagem pela pipeline
        mean, final_frame = get_line_mean(final_frame) #Obtem a media dos pixels brancos 
        intersection, final_frame = is_intersection(final_frame, mean) #Verifica se ha uma interseccao

        if(intersection):
            time.sleep(0.1)
            intersection_count += 1
            if(intersection_count > 5): #Se foi detectado uma interseccao 5 vezes consecutivas
                if(directions_count >= len(directions) - 1): #Chegou ao vertice final
                    current_vertex = path[-1]
                    final_vertex = int(input('Proximo Vertice: '))
                    last_path = path
                    path = mapa.get_path(current_vertex, final_vertex)
                    directions = mapa.get_written_path(path, last_path[-2])
                    directions_count = 0
                else: #Chegou a um vertice que nao seja o final
                    move_on_intersection(directions[directions_count+1]) #Faz uma curva ou se matem em frente
                    directions_count += 1
                intersection_count = 0

        else:
            keep_on_line(mean) #Usa a media para se manter na linha reta
            intersection_count = 0
    else:
        break

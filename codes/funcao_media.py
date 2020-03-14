def get_line_mean(mask):
    sum = 0 #Soma das posicoes dos pixels brancos
    count = 0 #Contador dos pixels brancos
    width = mask.shape[1]  # Define a largura da imagem
    height = mask.shape[0]  # Define a altura da imagem
    line = int(height / 4) #Define a linha em que a media ocorrera como 1/4 de sua altura
    for i in range(width):
        if(mask[line][i] == 255): #Se o pixel for branco
            sum += i
            count += 1
    
    if count == 0:
        return -1, mask

    mean = sum/count/width #Faz a media dos pixels e normaliza o resultado
    return mean, mask
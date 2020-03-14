def is_intersection(mask, mean):
    intersection = False
    mask_color = cv2.cvtColor(mask, cv2.COLOR_GRAY2BGR) #Converte a mascara para RGB para desenhar as linhas rosas
    width = mask.shape[1] #Define a largura da imagem
    height = mask.shape[0] #Define a altura da imagem
    line_analized = int(height / 4) #Define que a linha em que os pixels brancos serao analizados sera a linha de numero 1/4 da altura
    cv2.line(mask_color, (0, line_analized), (width, line_analized),
                (255, 0, 255), 2) #Desenha a linha horizontal em 1/4 da altura

    cv2.circle(mask_color, (int(mean * mask.shape[1]), line_analized), 5, (0, 0, 255), -1) #Desenha o circulo em cima da media dos pixels brancos na linha analizada
    left_limit = int(mean * width - 70) #Define a coluna em que sera procurado um piso tatil a esquerda da media
    cv2.line(mask_color, (left_limit, 0), (left_limit, int(height/2)),
                (255, 0, 255), 2) #Desenha uma linha na coluna em que sera procurado um piso tatil a esquerda da media
    left_sum = 0
    left_count = 0
    for i in range(int(height/2)):
        if (left_limit >= 0 and mask[i][left_limit] == 255):
            left_sum += i
            left_count += 1

    if left_count > 40: #Se houver pelo menos 40 pixels brancos na coluna a esquerda
        cv2.circle(mask_color, (left_limit, int(left_sum/left_count)), 5, (0, 0, 255), -1)
        intersection = True

    right_limit = int(mean * width + 70) #Define a coluna em que sera procurado um piso tatil a direita da media
    cv2.line(mask_color, (right_limit, 0), (right_limit, int(height/2)),
                (255, 0, 255), 2) #Desenha uma linha na coluna em que sera procurado um piso tatil a direita da media
    right_sum = 0
    right_count = 0
    for i in range(int(height/2)):
        if (right_limit < width and mask[i][right_limit] == 255):
            right_sum += i
            right_count += 1

    if right_count > 40: #Se houver pelo menos 40 pixels brancos na coluna a direita
        cv2.circle(mask_color, (right_limit, int(right_sum / right_count)), 5, (0, 0, 255), -1)
        intersection = True

    mask = mask_color
    return intersection, mask
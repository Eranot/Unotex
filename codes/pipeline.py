def pipeline(image):
    image = cv2.resize(image, (int(image.shape[1] / 2), int(image.shape[0] / 2))) #Redimiensiona a imagem para a metade de seu tamanho
    img_original = image

    image = cv2.blur(image, (31, 31)) #Filtro de media com kernel 31x31

    converted = cv2.cvtColor(image, cv2.COLOR_RGB2HLS) #Converte a imagem para HSL

    red_lower = np.uint8([106, 0, 74])
    red_upper = np.uint8([177, 255, 255])
    red_mask = cv2.inRange(converted, red_lower, red_upper) #Segmentacao da linha vermelha da imagem

    blue_lower = np.uint8([0, 68, 0])
    blue_upper = np.uint8([35, 188, 138])
    blue_mask = cv2.inRange(converted, blue_lower, blue_upper) #Segmentacao da linha azul da imagem

    if cv2.countNonZero(red_mask[0:100, 60:260]) > cv2.countNonZero(blue_mask[0:100, 60:260]): #Verifica se no quadrado a mascara vermelha esta mais ativa do que a azul
        mask = red_mask
    else:
        mask = blue_mask

    kernel = np.ones((5, 5), np.uint8) #Cria o kernel so com 1's para erodir e dilatar a imagem

    final = cv2.erode(mask, kernel, iterations=1) #Erode a mascara
    final = cv2.dilate(final, kernel, iterations=1) #Dilata a mascara

   return final
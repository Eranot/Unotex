import cv2
imagem = cv2.imread('minha_imagem.jpg', cv2.IMREAD_GRAYSCALE)
imagem = cv2.blur(imagem, (15, 15))
cv2.imshow('Imagem', imagem)
cv2.waitKey(0)
cv2.destroyAllWindows() 
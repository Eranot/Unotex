import cv2

imagem = cv2.imread('minha_imagem.jpg', cv2.IMREAD_GRAYSCALE)
imagem = cv2.blur(imagem, (15, 15))

ret, threshhold = cv2.threshold(imagem,130,255,cv2.THRESH_BINARY)

cv2.imshow('Imagem', threshhold)
cv2.waitKey(0)
cv2.destroyAllWindows()

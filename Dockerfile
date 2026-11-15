# Imagen base ligera con Nginx
FROM nginx:alpine

# Copia el sitio estático al directorio público de Nginx
COPY src/ /usr/share/nginx/html/

# Nginx escucha en el puerto 80 dentro del contenedor
EXPOSE 80

# Verificación de salud del servicio (wget viene incluido en Alpine/BusyBox)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://localhost/ || exit 1

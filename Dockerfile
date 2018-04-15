FROM nginx:latest
COPY ./default.conf /etc/nginx/conf.d/
COPY ./_book/ /usr/share/nginx/html

CMD ["nginx","-g","daemon off;"]
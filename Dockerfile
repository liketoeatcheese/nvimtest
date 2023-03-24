FROM alpine:latest
RUN apk update && apk add --no-cache cargo bash neovim git alpine-sdk && \
adduser -D user -h /home/user && \
chown -R user:user /home/user
USER root
WORKDIR /home/user
WORKDIR /home/user
COPY ./nvim/ /home/user/.config/nvim
COPY ./practice_progress_bar/ /home/user/practice_progress_bar
RUN chown -R user:user /home/user/
USER user
CMD ["bash"]

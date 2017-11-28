FROM scratch

#   nobody:nobody
USER 65534:65534

COPY server /

ENTRYPOINT ["/server"]

FROM tensorflow/serving:latest

# Copia tu carpeta modelo_cocina (que debe tener la subcarpeta "1" con saved_model.pb, variables/, assets/, fingerprint.pb)
COPY modelo_cocina /models/modelo_cocina

# Nombre de tu modelo
ENV MODEL_NAME=modelo_cocina

# Puerto REST que Cloud Run inyecta
ENV PORT=8080
EXPOSE ${PORT}

# Forzamos shell para expandir $PORT en runtime y bind a 0.0.0.0
ENTRYPOINT ["bash","-c","exec tensorflow_model_server \
  --rest_api_address=0.0.0.0 \
  --rest_api_port=${PORT} \
  --model_name=${MODEL_NAME} \
  --model_base_path=/models/${MODEL_NAME}"]

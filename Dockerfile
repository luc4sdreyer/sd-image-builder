FROM runpod/stable-diffusion:web-automatic-8.0.3

RUN mv /stable-diffusion-webui /workspace/stable-diffusion-webui && \
    cd /workspace/stable-diffusion-webui && \
    cp install-automatic.py ../ && \
    cp relauncher.py ../ && \
    cp webui-user.sh ../ && \
    cp cache-sd-model.py ../ && \
    cd /workspace/ && \
    rm -rf /workspace/stable-diffusion-webui && \
    cd /workspace/ && \
    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
    cd stable-diffusion-webui && \
    git checkout tags/v1.4.0 && \
    cp ../install-automatic.py ./ && \
    cp ../relauncher.py ./ && \
    cp ../webui-user.sh ./ && \
    cp ../cache-sd-model.py ./ && \
    python -m install-automatic --skip-torch-cuda-test && \
    cd /workspace/stable-diffusion-webui && \
    git clone https://github.com/deforum-art/sd-webui-deforum extensions/deforum && \
    cd extensions/deforum && \
    pip install -r requirements.txt && \
    cd /workspace/stable-diffusion-webui && \
    git clone https://github.com/Mikubill/sd-webui-controlnet.git extensions/sd-webui-controlnet && \
    cd extensions/sd-webui-controlnet && \
    pip install -r requirements.txt && \
    cd /workspace/stable-diffusion-webui/ && \
    mv /sd-models/SDv1-5.ckpt models/Stable-diffusion/ && \
    mv /cn-models/control_v11p_sd15_canny.pth extensions/sd-webui-controlnet/models && \
    python cache-sd-model.py --use-cpu=all --ckpt /sd-models/SDv1-5.ckpt && \
    pip cache purge

CMD ["/start.sh"]

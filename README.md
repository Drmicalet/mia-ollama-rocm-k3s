# 🦙 MIA Ollama ROCm K3s

Despliegue de Ollama con soporte ROCm para GPUs AMD en Kubernetes (K3s).

## 📋 Requisitos

| Componente | Versión | Notas |
|------------|---------|-------|
| K3s | v1.34+ | Kubernetes ligero |
| Longhorn | Latest | Almacenamiento distribuido |
| ROCm | 6.0+ | Drivers AMD GPU |
| GPU AMD | gfx1030 | RX 6950 XT / 6900 XT / 6800 XT |

## 🖥️ Hardware Probado

- **CPU**: AMD Ryzen 7 9800X3D (8 cores)
- **GPU**: AMD RX 6950 XT (16GB VRAM)
- **RAM**: 64GB DDR5
- **SO**: CachyOS Linux (Arch-based)

## 🚀 Instalación Rápida

```bash
# Clonar repositorio
git clone https://github.com/Drmicalet/mia-ollama-rocm-k3s.git
cd mia-ollama-rocm-k3s

# Ejecutar instalador
./scripts/install.sh

# Verificar instalación
./scripts/verify.sh
```

## 📦 Modelos Incluidos

| Modelo | Tamaño | Uso Principal |
|--------|--------|---------------|
| glm4:9b | 5.5 GB | General |
| qwen2.5:7b | 4.7 GB | Multilingual |
| mistral:7b | 4.4 GB | General |
| gemma2:2b | 1.6 GB | Rápido |
| gemma2:9b | 5.4 GB | Calidad |

## 🔧 Estructura

```
mia-ollama-rocm-k3s/
├── k8s/
│   ├── 00-namespace.yaml
│   ├── 01-configmap.yaml
│   ├── 02-pvc.yaml
│   ├── 03-deployment.yaml
│   ├── 04-service.yaml
│   ├── 05-model-puller.yaml
│   ├── 06-ingress.yaml
│   └── 07-networkpolicy.yaml
├── scripts/
│   ├── install.sh
│   ├── verify.sh
│   └── backup.sh
├── docs/
└── README.md
```

## 🌐 Uso de la API

```bash
# Listar modelos
curl http://localhost:31434/api/tags

# Generar texto
curl http://localhost:31434/api/generate -d '{
  "model": "gemma2:2b",
  "prompt": "Hola, ¿cómo estás?"
}'

# Chat
curl http://localhost:31434/api/chat -d '{
  "model": "qwen2.5:7b",
  "messages": [
    {"role": "user", "content": "Explica la relatividad"}
  ]
}'
```

## ⚡ Rendimiento

Con ROCm habilitado en RX 6950 XT:

| Modelo | Velocidad (GPU) | Velocidad (CPU) |
|--------|-----------------|-----------------|
| gemma2:2b | ~50-60 t/s | ~8-12 t/s |
| mistral:7b | ~25-35 t/s | ~4-6 t/s |
| qwen2.5:7b | ~20-30 t/s | ~3-5 t/s |
| glm4:9b | ~15-20 t/s | ~2-4 t/s |

## 🔍 Verificación de GPU

```bash
# Verificar que ROCm está funcionando
kubectl logs -n mia-ollama deployment/ollama-rocm | grep -i rocm

# Deberías ver algo como:
# llama_context: ROCm0 compute buffer size = 504.50 MiB
```

## 🛠️ Troubleshooting

### GPU no detectada

```bash
# Verificar dispositivos
ls -la /dev/kfd /dev/dri

# Verificar permisos
sudo chmod 777 /dev/kfd /dev/dri/renderD128
```

### Pod no inicia

```bash
# Verificar logs
kubectl describe pod -n mia-ollama -l app=ollama-rocm

# Verificar eventos
kubectl get events -n mia-ollama --sort-by='.lastTimestamp'
```

## 📄 Licencia

MIT License - Libre para uso personal y comercial.

## 🙏 Créditos

- [Ollama](https://ollama.ai/) - Motor de inferencia
- [ROCm](https://rocm.docs.amd.com/) - Plataforma GPU AMD
- [K3s](https://k3s.io/) - Kubernetes ligero
- [Longhorn](https://longhorn.io/) - Almacenamiento distribuido

---

**MIA v20a** - Sistema de IA Multinivel con ROCm

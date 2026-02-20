#!/bin/bash
# MIA Ollama ROCm - Instalador K3s
set -e

echo "🚀 Instalando MIA Ollama ROCm en K3s..."

# Verificar prerequisitos
command -v kubectl >/dev/null 2>&1 || { echo "❌ kubectl no instalado"; exit 1; }
kubectl get ns longhorn-system >/dev/null 2>&1 || { echo "⚠️  Longhorn no detectado, continuando..."; }

# Aplicar manifiestos en orden
for yaml in k8s/*.yaml; do
    echo "📦 Aplicando $yaml..."
    kubectl apply -f "$yaml"
done

# Esperar a que el pod esté listo
echo "⏳ Esperando a que el pod esté listo..."
kubectl rollout status deployment/ollama-rocm -n mia-ollama --timeout=300s

echo "✅ Instalación completada!"
echo "🌐 API disponible en: http://$(hostname):31434"

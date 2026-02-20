#!/bin/bash
# MIA Ollama ROCm - Verificador
set -e

echo "🔍 Verificando instalación MIA Ollama ROCm..."

# Verificar namespace
kubectl get ns mia-ollama || { echo "❌ Namespace no existe"; exit 1; }

# Verificar pods
echo "📊 Pods:"
kubectl get pods -n mia-ollama -o wide

# Verificar servicios
echo ""
echo "🌐 Servicios:"
kubectl get svc -n mia-ollama

# Verificar API
echo ""
echo "🔌 Probando API..."
curl -s http://localhost:31434/api/version | head -c 200 || echo "⚠️  API no accesible"

# Verificar modelos
echo ""
echo "🤖 Modelos:"
kubectl exec -n mia-ollama deployment/ollama-rocm -- ollama list

echo ""
echo "✅ Verificación completada!"

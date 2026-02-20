#!/bin/bash
# MIA Ollama ROCm - Backup de modelos
set -e

BACKUP_DIR="/casa/mia/backup/ollama-models-$(date +%Y%m%d)"
mkdir -p "$BACKUP_DIR"

echo "💾 Iniciando backup de modelos..."

# Copiar modelos del PVC
kubectl exec -n mia-ollama deployment/ollama-rocm -- tar czf /tmp/models.tar.gz -C /root/.ollama .
kubectl cp mia-ollama/ollama-rocm:/tmp/models.tar.gz "$BACKUP_DIR/models.tar.gz"

echo "✅ Backup completado en: $BACKUP_DIR"
ls -lh "$BACKUP_DIR"

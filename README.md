# Reserva de Horas Médicas – Proyecto DevOps integrador

Servicio web **estático** (HTML + CSS) para la reserva de horas médicas del *Centro de Salud Vida Plena*  
servido con **Nginx** dentro de **Docker** y orquestado con **Docker Compose**. 


> No incluye API ni base de datos. El formulario es una simulación y no almacena datos.

## Estructura

```
reserva-horas-medicas-devops/
├── .github/workflows/devops-automation.yml   # Automatización complementaria (GitHub Actions)
├── src/
│   ├── index.html                            # Formulario, datos de atención y estado del servicio
│   └── styles.css                            # Estilos
├── .env.example                              # Plantilla de variables (sin secretos reales)
├── .gitignore
├── Dockerfile                                # Basado en nginx:alpine
├── docker-compose.yml                        # Levanta el servicio en el puerto 8080
└── README.md
```

## Requisitos

- Git
- Docker Desktop instalado e iniciado (incluye Docker Compose)
- Navegador web

## Instalación

```bash
git clone https://github.com/NeverFunaki/reserva-horas-medicas-devops.git
cd reserva-horas-medicas-devops
cp .env.example .env        # En Windows (PowerShell): Copy-Item .env.example .env
```

El archivo `.env` es local y **no se sube a GitHub** (está en `.gitignore`).

## Ejecución

```bash
docker compose up -d --build
```

## Verificación

```bash
docker compose ps                     # Estado del contenedor (debe verse "running" / "healthy")
docker ps                             # Contenedores activos
curl http://localhost:8080            # O abrir http://localhost:8080 en el navegador
```

## Monitoreo básico

```bash
docker logs reserva-horas-web         # Registros de Nginx
docker stats --no-stream              # Consumo de CPU y memoria
```

## Detención

```bash
docker compose down
```

## Seguridad

- No se publican credenciales, tokens ni datos personales.
- Las variables se documentan en `.env.example` con valores ficticios; el `.env` real queda fuera del repositorio.
- `.gitignore` excluye `.env`, claves y certificados.
- El formulario no envía información: es una simulación sin backend.
- Antes de cada commit: `git status` y `git diff --staged` para revisar qué se sube.

## Flujo de trabajo Git

```bash
git checkout -b feature/formulario-reserva
git add .
git commit -m "feat: agrega formulario de reserva y estado del servicio"
git push -u origin feature/formulario-reserva
# Abrir Pull Request en GitHub -> revisión -> merge a main
```

## Automatización (complementaria)

`.github/workflows/devops-automation.yml` valida archivos obligatorios, verifica que no exista `.env` versionado, valida `docker-compose.yml`, construye la imagen y prueba que el servicio responda. No publica la aplicación en servidores externos.

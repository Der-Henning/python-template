# Two stage python docker image builder
FROM python:3.11 AS builder

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        python3-dev

# Install python packages
COPY requirements.txt /tmp/pip-tmp/
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN python -m pip install --no-cache-dir --upgrade pip && \
    python -m pip install --no-cache-dir -r /tmp/pip-tmp/requirements.txt

# Second stage
FROM python:3.11-slim

# Install required libraries
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#         additional-dependency
#     apt-get clean && \
#         rm -rf \
#         /tmp/* \
#         /var/lib/apt/lists/* \
#         /var/tmp/*

ARG USER="user"

# Create user
RUN addgroup --gid 1001 --system ${USER} && \
    adduser --shell /bin/false --disabled-password --uid 1001 --system --group ${USER}
RUN mkdir -p /app
RUN chown ${USER}:${USER} /app
USER ${USER}

WORKDIR /app

ENV PATH="/opt/venv/bin:$PATH"

# Copy build environment from builder
COPY --from=builder /opt/venv /opt/venv

# Copy application files
COPY --chown=${USER}:${USER} ./src .

CMD [ "python", "-u", "main.py" ]

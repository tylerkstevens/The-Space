# FROM node:lts AS base
# WORKDIR /app

# # By copying only the package.json and package-lock.json here, we ensure that the following `-deps` steps are independent of the source code.
# # Therefore, the `-deps` steps will be skipped if only the source code changes.
# COPY package.json package-lock.json ./

# FROM base AS prod-deps
# RUN npm install --production

# FROM base AS build-deps
# RUN npm install --production=false

# FROM build-deps AS build
# COPY . .
# RUN npm run build

# FROM base AS runtime
# COPY --from=prod-deps /app/node_modules ./node_modules
# COPY --from=build /app/dist ./dist

# ENV HOST=0.0.0.0
# ENV PORT=4321
# EXPOSE 4321
# CMD node ./dist/server/entry.mjs



FROM node:lts AS runtime
WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

ENV HOST=0.0.0.0
ENV PORT=4321
ENV SUPABASE_URL=https://rskrxipxebzrnicmvkmw.supabase.co
ENV SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJza3J4aXB4ZWJ6cm5pY212a213Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg1Nzg3NjUsImV4cCI6MjAzNDE1NDc2NX0.osYaEvHv3o0Ysg3z0oB6CAA5n58lSdV0JXKMWAwBRn4

EXPOSE 4321
CMD node ./dist/server/entry.mjs
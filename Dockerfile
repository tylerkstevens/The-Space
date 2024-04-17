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
ENV SUPABASE_URL=https://oolgohweoeyeynuacuos.supabase.co
ENV SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vbGdvaHdlb2V5ZXludWFjdW9zIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIyMDEyNTgsImV4cCI6MjAyNzc3NzI1OH0.UWYcDf8Ab-cO_l-z-6lMlxOd8a8UjbPmbYqiMhRI1Pg

EXPOSE 4321
CMD node ./dist/server/entry.mjs
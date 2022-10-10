#!/bin/bash

hugo --theme=blackburn
git add .
git commit -m "Modificación"
git push origin main
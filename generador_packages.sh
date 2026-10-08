# Genera el package.json de un modulo nuevo. Uso: ./generador_packages.sh aws-foo
# La version arranca en 0.0.0: release-please la sube en el primer release segun
# los commits convencionales. Hay que anadir el modulo tambien a
# release-please-config.json y a .release-please-manifest.json.
echo """
{
    \"name\": \"$1\",
    \"version\": \"0.0.0\",
    \"description\": \"CHANGEME\",
    \"main\": \"index.js\",
    \"scripts\": {},
    \"repository\": {
        \"type\": \"git\",
        \"url\": \"git+https://github.com/netexknowledge/platform-serverless-terraform-modules.git\"
    },
    \"author\": \"\",
    \"license\": \"ISC\"
}
"""

const path = require(`path`);
const { createFilePath } = require(`gatsby-source-filesystem`);

const _ = require(`lodash`);

exports.onCreateNode = ({ node, getNode, boundActionCreators }) => {
    const { createNodeField } = boundActionCreators
    if (node.internal.type === `MarkdownRemark`) {
        const slug = createFilePath({ node, getNode, basePath: `pages` })
        createNodeField({
            node,
            name: `slug`,
            value: slug,
        })
    }
};

exports.createPages = ({ graphql, boundActionCreators }) => {
    const { createPage } = boundActionCreators
    return new Promise((resolve, reject) => {
        graphql(`
      {
        allMarkdownRemark {
          edges {
            node {
              fields {
                slug
              }
            }
          }
        }
      }
    `).then(result => {
                result.data.allMarkdownRemark.edges.forEach(({ node }) => {
                    createPage({
                        path: node.fields.slug,
                        component: path.resolve(`./src/templates/blog-post.js`),
                        context: {
                            // Data passed to context is available in page queries as GraphQL variables.
                            slug: node.fields.slug,
                        },
                    })
                })
                resolve()
            })
    })
};

// exports.sourceNodes = ({ getNodes, boundActionCreators }) => {
//     const { createNodeField } = boundActionCreators;
//     const pageNodes = getNodes().filter(
//         node => node.internal.type === "MarkdownRemark"
//     );

//     pageNodes.forEach(pageNode => {
//         let pathFragments = [];
//         let tmpNode = pageNode;
//         do {
//             pathFragments.push(tmpNode.slug);
//             tmpNode = pageNodes.find(
//                 node => node.id === tmpNode.parent
//             );
//         } while (tmpNode);

//         const path = pathFragments.reverse().join("/");
//         createNodeField({
//             node: pageNode,
//             name: `path`,
//             value: path,
//         });
//     });
// };
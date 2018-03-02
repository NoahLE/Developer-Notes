import React from "react"

export default ({ data }) => {
    console.log(data)
    return (
        <div>
            <h1>My Site's Files</h1>
            <table>
                <thead>
                    <tr>
                        <th>Location</th>
                        <th>File Size</th>
                        <th>File Type</th>
                        <th>Last Updated</th>
                    </tr>
                </thead>
                <tbody>
                    {data.allFile.edges.map(({ node }, index) =>
                        <tr key={index}>
                            <td>
                                {node.relativePath}
                            </td>
                            <td>
                                {node.prettySize}
                            </td>
                            <td>
                                {node.extension}
                            </td>
                            <td>
                                {node.birthTime}
                            </td>
                        </tr>
                    )}
                </tbody>
            </table>
        </div>
    )
}

export const query = graphql`
  query MyFilesQuery {
    allFile {
      edges {
        node {
          relativePath
          prettySize
          extension
          birthTime(fromNow: true)
        }
      }
    }
  }
`


ellipsoid = function(x, y, z, segments = 51, robust = TRUE, level = 0.95){

    if (robust) {
      v <- MASS::cov.trob(cbind(x, y, z), tol = 0.001)
      shape <- v$cov
      center <- v$center
    }
    else {
        v <- cov.wt(cbind(x, y))
        shape <- v$cov
        center <- v$center
    }

    dfn <- 3
    dfd <- length(x) - 1
    radius <- sqrt(dfn * qf(level, dfn, dfd))

    theta <- (0:segments) * 2 * pi/segments
    phi <- (0:segments) * pi/segments

    library(pracma)
    mgrd <- meshgrid(phi, theta)
    phi <- mgrd$X
    theta <-  mgrd$Y

    x = cos(theta)*sin(phi) ; dim(x) <- NULL
    y = sin(theta)*sin(phi) ; dim(y) <- NULL
    z = cos(phi)            ; dim(z) <- NULL
    sphere <- cbind(x, y, z)

    Q <- chol(shape, pivot = TRUE)
    order <- order(attr(Q, "pivot"))

    elli <- t(center + radius * t(sphere %*% Q[, order]))
    colnames(elli) <- c("x", "y", "z")

    return(elli)
}

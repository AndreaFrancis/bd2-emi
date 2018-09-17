@transaction.atomic()
def save_points(self,save=True):

    user = User.create('jj','inception','jj','1234')
    sp1 = transaction.savepoint()

    user.name = 'starting down the rabbit hole'
    user.stripe_id = 4
    user.save()

    if save:
        transaction.savepoint_commit(sp1)
    else:
        transaction.savepoint_rollback(sp1)
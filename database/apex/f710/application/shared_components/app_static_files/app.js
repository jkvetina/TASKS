const draggables = document.querySelectorAll('.TASK');
const droppables = document.querySelectorAll('.TARGET');

draggables.forEach((task) => {
    task.addEventListener('dragstart', () => {
        task.classList.add('DRAGGING');
    });
    //
    task.addEventListener('dragend', (p) => {
        task.classList.remove('DRAGGING');
        //
        var sorted          = [];
        var target_primary  = p.target.parentElement.getAttribute('id');
        var target_alt      = p.target.parentElement.parentElement.getAttribute('id');
        //
        const target        = target_primary.indexOf('TASK_') === 0 ? target_alt : target_primary;
        const task_id       = task.getAttribute('id').replace('TASK_', '');
        const status_id     = target.replace('STATUS_', '').split('_SWIMLANE_')[0];
        const swimlane_id   = target.replace('STATUS_', '').split('_SWIMLANE_')[1];
        const tasks         = document.getElementById(target).querySelectorAll('.TASK');
        //
        tasks.forEach(function(task) {
            sorted.push(task.getAttribute('id').replace('TASK_', ''));
        });
        sorted = sorted.join(':');
        //
        console.group('TASK_MOVED');
        console.log('TASK     :', task_id);
        console.log('TARGET   :', target, target_primary, target_alt);
        console.log('STATUS   :', status_id);
        console.log('SWIMLANE :', swimlane_id);
        console.log('SORTED   :', sorted);
        console.groupEnd();
        //
        apex.server.process('UPDATE_TASK',
            {
                x01: task_id,
                x02: status_id,
                x03: swimlane_id,
                x04: sorted
            },
            {
                dataType: 'text',
                success: function(pData) {
                    console.log('RESULT', pData);
                    if (pData.indexOf('sqlerrm') >= 0) {
                        apex.message.showErrors([{
                            type        : 'error',
                            location    : ['page', 'inline'],
                            pageItem    : '',
                            message     : pData.split('sqlerrm:')[1],
                            unsafe      : false
                        }]);
                    }
                    else {
                        apex.message.showPageSuccess(pData);
                    }
                }
            }
        );
    });
});

droppables.forEach((zone) => {
    zone.addEventListener('dragover', (e) => {
        e.preventDefault();
        //
        const curr_task = document.querySelector('.DRAGGING');
        const last_task = insertAboveTask(zone, e.clientY);
        //
        //console.log('DRAGGING', curr_task.getAttribute('id'), zone.getAttribute('id'));
        //
        if (!curr_task) {
            zone.appendChild(curr_task);
        }
        else {
            zone.insertBefore(curr_task, last_task);
        }
    });
});

const insertAboveTask = (zone, mouseY) => {
    const els = zone.querySelectorAll('.TASK:not(.DRAGGING)');
    //
    let closest_task   = null;
    let closest_offset = Number.NEGATIVE_INFINITY;
    //
    els.forEach((task) => {
        const { top } = task.getBoundingClientRect();
        const offset  = mouseY - top;
        //
        if (offset < 0 && offset > closest_offset) {
            closest_offset = offset;
            closest_task   = task;
        }
    });
    //
    return closest_task;
};

